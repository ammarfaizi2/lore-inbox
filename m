Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTJNJtO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 05:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTJNJs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 05:48:57 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:45455 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262111AbTJNJsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 05:48:08 -0400
Date: Tue, 14 Oct 2003 10:46:55 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Piet Delaney <piet@www.piet.net>
Cc: George Anzinger <george@mvista.com>, Clayton Weaver <cgweav@email.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Circular Convolution scheduler
Message-ID: <20031014094655.GC24812@mail.shareable.org>
References: <20031006161733.24441.qmail@email.com> <3F833C06.7000802@mvista.com> <1066120643.25020.121.camel@www.piet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066120643.25020.121.camel@www.piet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piet Delaney wrote:
> circular convolution is used with the Fast Fourier Transform.
> The frequency data goes from -N/2 ...0 ,,,, +N/2,
> multiplying in the frequency domain is the same as
> convolving in the time or space domain. The result of multiplying
> a time series by say a filter is the same as convolving it
> with the FFT of the filter. Both domains wrap around with the
> FFT, so the normal convolution associated with the Fourier
> transform is replace with the circular convolution.
> 
> Many prediction algorithms are based on digital signal processing.
> The Kalman filter for example was used by Harvey for forecasting
> financial markets. The kernel likely has lots of time series that
> could be used for system identification for predicting how to best
> use system resources.

Ok, but what is "circular convolution scheduling"?

-- Jamie
