Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWJEUU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWJEUU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWJEUU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:20:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:12606 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751234AbWJEUU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:20:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jELz3oRYb2ypqgJ05OOSfRm4qn/t4ooQDYHlpGWfv01rdEaDZbGGFLYNkwTB/EWt+3dcGG4oN2JjWzS4goj1+9C6ASRblXANP1WE/voReNXDF9auXGbkz719safNGUaFuOK2nWJ3dgI5wTZ5z0Bb+Lm31l9Rw8Dno5qrW8Ue+ec=
Message-ID: <d120d5000610051320v231635f2lc889e9144e6cf78b@mail.gmail.com>
Date: Thu, 5 Oct 2006 16:20:54 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Cc: "David Howells" <dhowells@redhat.com>,
       "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, "Greg KH" <greg@kroah.com>,
       "David Brownell" <david-b@pacbell.net>,
       "Alan Stern" <stern@rowland.harvard.edu>
In-Reply-To: <20061005124601.94ed7194.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002132116.2663d7a3.akpm@osdl.org>
	 <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	 <18975.1160058127@warthog.cambridge.redhat.com>
	 <20061005124601.94ed7194.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/06, Andrew Morton <akpm@osdl.org> wrote:
>
> A quick survey of the wreckage:
>
> - Dmitry's input git tree breaks a bit

Ignore my tree for now, it needs redoing... I will reset it to kill
the 3 problematic patches if I have time tonight, otherwise it matches
with what Linus has in his tree.

-- 
Dmitry
