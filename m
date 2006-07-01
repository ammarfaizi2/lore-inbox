Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWGAOTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWGAOTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWGAOTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:19:08 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:55263 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751026AbWGAOTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:19:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dFehJv9v/S4+/fOc1HyQWmYxxe4kEmHgyjlp3ltAKB93YfB/xJeUVL6aBK4oUpzPAwtn1QEzcmrq5//Ymtnr8sOrhdMkzlLIZpO2OVKLDHnsUACGa1VLyDyKcZLIJlBtf5hB6IeaFun+EHS8labo2fNeq23FfEZVLfpfej8K9sk=
Message-ID: <a44ae5cd0607010719i7649d007qbd606a3ce1fef37d@mail.gmail.com>
Date: Sat, 1 Jul 2006 07:19:07 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0607010710h227ce03fv8a98702a04306f7f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060630065041.GB6572@elte.hu>
	 <20060630111734.GA22202@gondor.apana.org.au>
	 <20060630113758.GA18504@elte.hu>
	 <a44ae5cd0606301321y6ce6b7dbo2b405d3d76a670f1@mail.gmail.com>
	 <20060630203804.GA1950@elte.hu>
	 <a44ae5cd0606301545s33496174lcd7136d8bf41897@mail.gmail.com>
	 <1151746867.3195.19.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607010706k74c30a9ey6b7eac49d11e7827@mail.gmail.com>
	 <20060701140750.GA7342@gondor.apana.org.au>
	 <a44ae5cd0607010710h227ce03fv8a98702a04306f7f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, the patch worked!  Thanks.

BTW, I noticed this unrelated issue when recompiling:
WARNING: "__stack_chk_fail"
[drivers/net/wireless/hostap/hostap_plx.ko] undefined!
WARNING: "__stack_chk_fail"
[drivers/net/wireless/hostap/hostap_pci.ko] undefined!
WARNING: "__stack_chk_fail" [drivers/net/wireless/hostap/hostap_cs.ko]
undefined!

Cheers,
          Miles
