Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753921AbWKFXT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbWKFXT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 18:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbWKFXT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 18:19:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:27411 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753921AbWKFXTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 18:19:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ees0OQtcx4OI+lKlXj6COE5dt8FLt0RX7Q81AWT8LPiQtNXxBG91qqhTpdGwL1y8PTK3uaW7C5xjKE11Yi2oyPlDGqJ7losV+S8/mfaprd/j5UKtiF18aOfc3U4BtVK5WymQG9Pb8V8nfAbT+FSKLHpXd+u6Vh1aPvMwgyOmby8=
Message-ID: <a36005b50611061519p1dcdce98v9f8cee920ade0f63@mail.gmail.com>
Date: Mon, 6 Nov 2006 15:19:23 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] conditionalize some x86-64 options
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <200611050208.23814.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a36005b50611041624x1b9f2602h8d5b90b3337953e2@mail.gmail.com>
	 <200611050208.23814.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/06, Andi Kleen <ak@suse.de> wrote:
> No -- the CPU selection on x86-64 means "optimize for", but doesn't
> mean don't run on other CPUs.

Then please explain this:

config X86_HT
        bool
        depends on SMP && !MK8
        default y
