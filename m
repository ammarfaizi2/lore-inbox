Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWJEIfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWJEIfE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWJEIfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:35:03 -0400
Received: from mx10.go2.pl ([193.17.41.74]:21906 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751344AbWJEIfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:35:01 -0400
Date: Thu, 5 Oct 2006 10:39:36 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: "Axel C\. Voigt" <Axel.Voigt@qosmotec.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Problems with hard irq? (inconsistent lock state)
Message-ID: <20061005083936.GA8317@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	"Axel C. Voigt" <Axel.Voigt@qosmotec.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org
References: <46E81D405FFAC240826E54028B3B02953B22@aixlac.qosmotec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46E81D405FFAC240826E54028B3B02953B22@aixlac.qosmotec.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 10:58:48PM +0200, Axel C. Voigt wrote:
> Hello,
> 
> problem seems solved, testing extensively does not show the described behavior any more. What exactly does the patch using _irqsave functions instead of their counterparts? Is this worth to make public patch or just a quick hack to solve this particular problem?

It is a real problem but you have to have some "luck" to hit this.

Wish you luck,

Jarek P.
