Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWG3Jc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWG3Jc0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWG3Jc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:32:26 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:14123 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932126AbWG3JcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:32:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FWwmw33chYNHWaQE98VjDT5p7ek3FnJsdQeh/Elui5yhJ+S6doR3H5s84ZH76HEe5YcyivNuowgAOHfN/bT/81xP6WbMJTuYH3LeCP8M5MlRh/RSwTF6VkPMuMTgRCCoXVZXaBH/PtmIV9kM9sW7fQwMH/hknY1GU/X7UmnFnww=
Message-ID: <3888a5cd0607300232o400c76d8gcd006b7f45ecc71@mail.gmail.com>
Date: Sun, 30 Jul 2006 11:31:24 +0159
From: "Jiri Slaby" <lnx4us@gmail.com>
To: heavenscape <masonduan1@sina.com>
Subject: Re: How to port a legacy device driver to a new Linux platform?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5535638.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5535638.post@talk.nabble.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, heavenscape (sent by Nabble.com) <lists@nabble.com> wrote:
> Hi all,
>
> I have a legacy PCI fiber card running under Red Hat Linux 7.3, and I have
> all the source code of its driver developped by others. Please see the
> attachment.
>
> http://www.nabble.com/user-files/135/cyport71.tar cyport71.tar
>
> It is working fine right now. But I am going to upgrade my OS to Rea Hat
> Enterprise Linux AS 4, I am not sure how can I recompile and install this
> fiber card in the new OS.  I am new to Linux and have minimal experience in
> programming Linux. But this card is very important to me.
>
> Any suggestion is highly appreciated!!  Thanks!!

You may do rework of the driver and post it: see Documentation/HOWTO,
especially Documentation/SubmittingDrivers.

It won't be so hard, if you don't feel cool enough, I may try my best,
but tell me the source (cvs?) address of the drivers. What kind of
device is that?

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
