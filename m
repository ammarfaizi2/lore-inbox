Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314065AbSDKOIr>; Thu, 11 Apr 2002 10:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314067AbSDKOIq>; Thu, 11 Apr 2002 10:08:46 -0400
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:23044 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S314065AbSDKOIp>; Thu, 11 Apr 2002 10:08:45 -0400
Date: Thu, 11 Apr 2002 16:08:31 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Erik Andersen <andersen@codepoet.org>, Amol Kumar Lad <amolk@ishoni.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Reducing root filesystem
Message-ID: <20020411140831.GE1405@arthur.ubicom.tudelft.nl>
In-Reply-To: <7CFD7CA8510CD6118F950002A519EA3001067D06@leonoid.in.ishoni.com> <20020410152813.GA22103@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 09:28:13AM -0600, Erik Andersen wrote:
> On Wed Apr 10, 2002 at 07:38:09PM +0530, Amol Kumar Lad wrote:
> >   I am porting Linux to an embedded system. Currently my rootfilesystem is
> > around 2.5 MB (after keeping it to minimal and adding tools like busybox). I
> > want to furthur reduce it to say maximum of 1.5 MB. 
> > Please suggest some link/references where I can find the details to optimise
> > my root filesystem
> 
> busybox and uClibc are both a good start...

Yup. Busybox+tinylogin with glibc makes a 900kB (compressed) ramdisk on
StrongARM. I think I can make this a lot smaller when I use uClibc.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
