Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267782AbTBRMow>; Tue, 18 Feb 2003 07:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267780AbTBRMow>; Tue, 18 Feb 2003 07:44:52 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:28588 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267782AbTBRMov>; Tue, 18 Feb 2003 07:44:51 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Greg KH <greg@kroah.com>
Subject: Re: [BUG] link error in usbserial with gcc3.2
Date: Tue, 18 Feb 2003 07:50:02 -0500
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <3DF453C8.18B24E66@digeo.com> <200302112059.07685.tomlins@cam.org> <20030218055125.GA4927@kroah.com>
In-Reply-To: <20030218055125.GA4927@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302180750.02685.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 18, 2003 12:51 am, Greg KH wrote:
> On Tue, Feb 11, 2003 at 08:59:07PM -0500, Ed Tomlinson wrote:
> > I dug into this a bit more.  It would seem to be a compiler
> > bug, where it tries to branch back 129 bytes...  I will report
> > it using debian channels.
> >
> > The following change will let things compile until gcc is fixed.
>
> Thanks for finding this, but I don't think that work around is ok as
> it's printing out something that isn't necessary :)

Agreed.  I posted it just so anyone with the problem would know one
way to fix it - I do not propose this for inclusion.

Ed
