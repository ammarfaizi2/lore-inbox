Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVE0Qqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVE0Qqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 12:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVE0Qqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 12:46:50 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:8298 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262499AbVE0Qqo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 12:46:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MoFewp5Tw624/13ba/oCZFk+JCGe/0eqYFCQ8lyaGH7O+qa9m0linI0v2HBsEizkkplCScLGEmmNZNudIQR5onzWUCcOAbLFbkGZNL0Jy4dU0jTtm+GZcR9UGbWu3wzaE1H91zCA+w3yqwPCvXbE6lHAgJlwNVYmw68Yq3W5Rn0=
Message-ID: <d120d50005052709467c523abc@mail.gmail.com>
Date: Fri, 27 May 2005 11:46:42 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: vherva@vianova.fi
Subject: Re: 2.6.12-rc4 broke right <win>-key
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050527163549.GV16169@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050527163549.GV16169@viasys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/05, Ville Herva <vherva@vianova.fi> wrote:
> After upgrading from 2.6.11-rc1-ck2 to 2.6.12-rc4, the right <win>-key on my
> HP "multimedia" keyboard (something like http://www.pc-netto.dk/templates/product.asp?productguid=C4742B%23ABY&groupguid=11437)
> seized to work. The left one still works. The earlier kernels I've run
> never showed this problem (although the multimedia keys seem to map to
> different codes in each and every kernel version, which is slightly
> annoying.) The older kernels I've tried include 2.6.8.1-mm2, 2.6.8.1,
> 2.6.6-mm4, 2.6.3, and a heap of 2.4 kernels.
> 

Hi,

This patch from Vojtech shoudl get you going:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111712306027138&q=raw

-- 
Dmitry
