Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161329AbWG1WKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161329AbWG1WKo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 18:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWG1WKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 18:10:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:4220 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751365AbWG1WKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 18:10:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m5Mvmt8yL7s/dkg9MhEkROIGXbtaVeKk9zGgShwgJuR2jwdn+2v3ZTDNw66uDBzu62Z+8zmmMM3oJEvHB9itMbh9AkAjjC+Se8HfEqD0+ZR8C6rk3S7i0TGRfJ29SgbkFhH9tvNVo1hbglmBFr5CWai0RghdDIJqljcs3UWIxus=
Message-ID: <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com>
Date: Sat, 29 Jul 2006 01:10:40 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Generic battery interface
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Pavel Machek" <pavel@suse.cz>,
       "Brown, Len" <len.brown@intel.com>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <200607281557.k6SFvn09022794@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz>
	 <20060728134307.GD29217@suse.cz>
	 <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com>
	 <200607281557.k6SFvn09022794@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> Is there a reliable (or hack-worthy) way for the kernel to determine how
> often the values are re-posted by the hardware?

That's hardware-specific. Some drivers can know, others may just
assume 1sec or 0.1sec or whatever.

  Shem
