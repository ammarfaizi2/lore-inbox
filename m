Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261239AbRELNSp>; Sat, 12 May 2001 09:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261240AbRELNSf>; Sat, 12 May 2001 09:18:35 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:17929 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261239AbRELNSa>; Sat, 12 May 2001 09:18:30 -0400
Date: Sat, 12 May 2001 15:18:04 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Akos Maroy <darkeye@tyrell.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Process accessing a Sony DSC-F505V camera through USB as a storage device hangs.
Message-ID: <20010512151803.C8826@arthur.ubicom.tudelft.nl>
In-Reply-To: <3AFD2E41.213CFB47@tyrell.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFD2E41.213CFB47@tyrell.hu>; from darkeye@tyrell.hu on Sat, May 12, 2001 at 03:36:17PM +0300
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2001 at 03:36:17PM +0300, Akos Maroy wrote:
> [1.] One line summary of the problem:
> 
> Process accessing a Sony DSC-F505V camera through USB as a storage
> device hangs.

[snip]
 
> [7.3.] Module information (from /proc/modules):
> 
> NVdriver              629488  12 (autoclean)
> usb-storage            48928   1
> uhci                   23680   0 (unused)
> usbcore                53008   0 [usb-storage uhci]
> nls_iso8859-1           2864   4 (autoclean)
> nls_cp437               4384   4 (autoclean)
> vfat                    9328   4 (autoclean)
> fat                    32160   0 (autoclean) [vfat]

You're using the binary only NVdriver. Boot the system without that
driver and try to recreate the problem. If not, you'll have to contact
nvidia.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
