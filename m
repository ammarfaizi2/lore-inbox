Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbRFKR0d>; Mon, 11 Jun 2001 13:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbRFKR0X>; Mon, 11 Jun 2001 13:26:23 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:33039 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261173AbRFKR0I>; Mon, 11 Jun 2001 13:26:08 -0400
Date: Mon, 11 Jun 2001 19:18:47 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: procfs get_info() method obsolete?
Message-ID: <20010611191846.A3756@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can the procfs get_info() method be considered obsolete? When reading
this code fragment from fs/proc/generic.c I think yes:

        if (dp->get_info) {
                /*
                 * Handle backwards compatibility with the old net
                 * routines.
                 */
                n = dp->get_info(page, &start, *ppos, count);

However, I'd rather be sure before I start documenting lies in the
procfs-guide.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
