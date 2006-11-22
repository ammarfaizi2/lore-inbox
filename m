Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161735AbWKVBng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161735AbWKVBng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 20:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161733AbWKVBnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 20:43:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:10211 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161735AbWKVBne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 20:43:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VFiPA2knKHTb+fUqonzaVhYt6cbzSOd3ISOXxZy8SofCmNYA/Q4RO6k8n7fqhfH3JqZWHWAETeKdH0+hvzqEMy3DP0qUNZRyipZqK3qXCzirI/KOSpA7J+hmZ9yGhluaMT+y+hL79hfrWpNMUwuuCAYZ5owBH37mq4wQmKhrXQs=
Message-ID: <4563AB3E.9050305@gmail.com>
Date: Wed, 22 Nov 2006 10:43:26 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6][RESEND] ata_piix: IDE mode SATA patch for
 Intel ICH9
References: <39B20DF628532344BC7A2692CB6AEE07A5A356@orsmsx420.amr.corp.intel.com>
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE07A5A356@orsmsx420.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gaston, Jason D wrote:
> I was thinking that if a functional difference was found, it would be
> easier to tweak.
> 
> There are differences between the ICH8 and ICH9 SATA controller.  For
> example, the PCS register now has port present bits that used to be
> reserved in ICH8.  I'm not sure how or if these could be used in
> ata_piix.

Separating ich9 out from ich8 isn't difficult.  Let's do that when there 
is need.  ata_piix always has been using the same entry if there is no 
code difference and I don't see any reason to depart from that with ich9.

Thanks.

-- 
tejun
