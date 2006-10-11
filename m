Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030583AbWJKQQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030583AbWJKQQi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030670AbWJKQQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:16:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58080 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030583AbWJKQQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:16:37 -0400
Date: Wed, 11 Oct 2006 17:16:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1-mm1] Export jiffies_to_timespec()
Message-ID: <20061011161628.GA1873@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	john stultz <johnstul@us.ibm.com>
References: <452C3CA6.2060403@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452C3CA6.2060403@goop.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 05:36:54PM -0700, Jeremy Fitzhardinge wrote:
> Export jiffies_to_timespec; previously modules used the inlined header 
> version.

NACK, drivers shouldn know about these timekeeping details and no
in-tree driver uses it (fortunately)

