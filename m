Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275255AbRJFPan>; Sat, 6 Oct 2001 11:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275256AbRJFPad>; Sat, 6 Oct 2001 11:30:33 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:41744 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S275255AbRJFPaN>; Sat, 6 Oct 2001 11:30:13 -0400
Date: Sat, 6 Oct 2001 17:30:25 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: llx@swissonline.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: proc file system
Message-ID: <20011006173025.F12624@arthur.ubicom.tudelft.nl>
In-Reply-To: <200110052202.f95M2Ig16051@mail.swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110052202.f95M2Ig16051@mail.swissonline.ch>; from llx@swissonline.ch on Sat, Oct 06, 2001 at 12:02:18AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2001 at 12:02:18AM +0200, llx@swissonline.ch wrote:
> i've written a prog interface for my logger utility to make it easy
> to transport my logging information from kernel to userspace using
> shell commands. now i want to use tail -f /prog/<mylogfile>. what
> do i have to do for that to work. when using tail my loginfo gets
> read form my ringbuffer, but nothing gets printed in the terminal.

I think you actually want a character device instead of a /proc file.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
