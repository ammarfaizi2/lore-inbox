Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264709AbUEaUi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbUEaUi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 16:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbUEaUi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 16:38:57 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:26056 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264709AbUEaUi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 16:38:56 -0400
Message-ID: <40BB97C6.9020109@colorfullife.com>
Date: Mon, 31 May 2004 22:38:30 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Trascendental functions are _not_ computed by series in practice, rational
>approximations (polinomial / polinomial) are used instead. Or interpolate
>in a smallish table.
>
Is that really faster on modern cpus? The multiplier is fully pipelined 
and a division takes 25-40 cycles.

--
    Manfred

