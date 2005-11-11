Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVKKTX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVKKTX2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVKKTX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:23:28 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:7853 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751090AbVKKTX1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:23:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TDFV25K9bAvlWFU3aJJn8UUxjb6tywwDQT57RhtUB+yGEe2DFoigpYRTT0axz789qA8m9y7AJcZA8oQeoWjoH4RweV3HElw7aRkMZXFjSJdROikKjPVzpTk1lkdncuDCyshG3UfP62sHVKTs+AW2YHTU1i4rNuLCe+154CEbdyQ=
Message-ID: <1e62d1370511111123y6d5f557fi9ce1617d2de7342@mail.gmail.com>
Date: Sat, 12 Nov 2005 00:23:27 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: =?ISO-8859-1?Q?Michael_=C5lenius?= <michael.alenius@gmail.com>
Subject: Re: Please report this to linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6a42705d0511111042p1e92b0adsf9aa91784b443529@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <6a42705d0511111042p1e92b0adsf9aa91784b443529@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/05, Michael Ålenius <michael.alenius@gmail.com> wrote:
> Upgraded  to fedora FC4 Development.repo.(kernel-2.6.14-1.1660_FC5)
> Newbie.So don't know which part to send,or if all of dmesg.
> Please inform me of what you need?If anything.
>

The thing depends on what sort of error you get ? Mostly the errors
are Kernel Bug at line no <xx> in <file_name>, Kernel Panic, Out of
Memory or Segmentation Fault which can make your system halt or might
crash kernel or some of your applications, then you have to send the
error log/messages which comes after the error message and these are
called OOPS Messages, for better understanding just look at
Documentation/oops-tracing.txt (or
http://lxr.linux.no/source/Documentation/oops-tracing.txt) or search
google for OOPs messages !


> SELinux: initialized (dev hdc, type iso9660), uses genfs_contexts
> application mixer_applet2 uses obsolete OSS audio interface
> eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
> eth0: no IPv6 routers present
> ISO 9660 Extensions: Microsoft Joliet Level 3
> ISOFS: changing to secondary root
> SELinux: initialized (dev hdc, type iso9660), uses genfs_contexts
> program ddcprobe is using MAP_PRIVATE, PROT_WRITE mmap of VM_RESERVED
> memory, wh ich is deprecated. Please report this to
> linux-kernel@vger.kernel.org

The log portion you send here is not actually a error, its just
telling you that program ddcprobe is using some symbols which are
marked as deprecated (with in the code) and will be removed (for each
deprecated message related to kernel actually ask you to report it to
linux-kernel mailing list)


--
Fawad Lateef
