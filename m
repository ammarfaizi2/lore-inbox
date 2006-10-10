Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWJJKrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWJJKrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 06:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWJJKrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 06:47:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:34614 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751441AbWJJKrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 06:47:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=s2dVEIkDCwEfRuq/9Poa4Y0xDWk33FiR/NUuv2tSNvDmeG/K29B/8d24btiAiioZ5dE49IT8UkYe5HXyjBerCg0RBwBcsXqWZkhBn6Fc3L5zNdzOiLkyIuiXblppOIRz8DoDvj/SfA84zzYT0auV8cIxMov56ebNL3KKz+DTwmU=
Message-ID: <9a0545880610100347hc2ce930w2b1bce7aab00f486@mail.gmail.com>
Date: Tue, 10 Oct 2006 03:47:38 -0700
From: "Steve Hindle" <mech422@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Abit AI-7, 2.6.18-mm3 requires 'pci=routeirq'
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I finally figured out why my box was hard locking... I seems
to require 'pci=routeirq' boot option.  So far, I've only tested it
with 2.6.18-mm3 but it appears to be working well.

For googles benefit: Machine crash under heavy I/O load Abit AI-7 2.6.16 2.6.18

One last thing - I noticed I also get a 'pciquirk' claming that ICH4
has reserved a region - but the machine has an ICH5/ICH5R in it...

Thanks to everyone for a great system and all their hard work!
Steve
