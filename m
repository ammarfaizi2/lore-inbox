Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbVF3OGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVF3OGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 10:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbVF3OGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 10:06:35 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:34452
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S262828AbVF3OGc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 10:06:32 -0400
Date: Thu, 30 Jun 2005 15:06:31 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Ville Sundell <ville.sundell@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Build-in XML support?
In-Reply-To: <ec2c5c2205063002091ba9e818@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0506301445180.31917@ppg_penguin.kenmoffat.uklinux.net>
References: <ec2c5c2205062903511d62d6bf@mail.gmail.com>
 <ec2c5c2205063002091ba9e818@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2005, Ville Sundell wrote:

> Sorry guys!
> I say it wrong way, I mean:
> Other programs would like use build-in and "standard" linux XML-parser.
>

 Applications should be using whatever the libraries available to them
provide.  This does *not* belong in the kernel.

> It would make standard way to read xml-files in Linux?
> Advertise speech:
>     No more 1 000 different XML readers, only one, and people can
> make it better :D
>

 Diversity is good.  Competition between projects often benefits the end
users.  If you want to write a better XML parsing library, or to assist
one of the existing projects, please do so (after you have identified
whatever shortcomings you see in the existing choices) - but in
userspace.  And in userspace you will find that many potential users of
an xml parser are kernel-agnostic - they run on linux 2.2 or 2.4 (which
are in maintenance mode), BSDs, and others.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

