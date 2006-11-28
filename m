Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935800AbWK1KPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935800AbWK1KPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935801AbWK1KPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:15:48 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:64423 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S935800AbWK1KPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:15:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=fzjtvR56vG3qA+T8EmKqDzAe3P7r1RJ/zxzh5lZ9zDxEiWCHd3CLMLGFi494Ns7+DthHAf6g3f95FNK5gaiZ3DHSNVVBKGP5hTzJ7Zpm/dilCje2bfmjYi9dSPy9OEzLGMQcT/GwzvI0k6njVGe7hUknvbQnIU8NZguIu36c4ik=
Date: Tue, 28 Nov 2006 19:08:32 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.19-rc6-mm2
Message-ID: <20061128100832.GA2217@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20061128020246.47e481eb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128020246.47e481eb.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 02:02:46AM -0800, Andrew Morton wrote:
> -input-make-serio_register_driver-return-error.patch
> -input-check-serio_register_driver-error.patch
> -input-change-to-gfp_kernel-for-serio_register_driver-event-allocation.patch

Please drop
input-check-whether-serio-dirver-registration-is-completed.patch, too.
Alternative fix is merged in input.git. So this is unnecessary.

