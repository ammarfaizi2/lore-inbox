Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262930AbVG2X2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbVG2X2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 19:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVG2X2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 19:28:34 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:1500 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262879AbVG2X1r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 19:27:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VZ1HLhulo7sSi615FVyNwzCaS+C94j3LGbSv55O/HAByutbqNjbcyUWC7/FEKl8ItJjPQCNj7cz6DpCtMXhvQS/qAp89LQTX16v+WJsJ7CV38rI2pL/xoL6UL6XmX7HrME7rVBDkZeeFmg/DtQ9jFbZh+0yFWBecyLv5vpNtZhc=
Message-ID: <86802c440507291627114445@mail.gmail.com>
Date: Fri, 29 Jul 2005 16:27:46 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64: sync_tsc fix the race (so we can boot)
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <86802c4405072913415379c5a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <m1slxz1ssn.fsf@ebiederm.dsl.xmission.com>
	 <86802c44050728092275e28a9a@mail.gmail.com>
	 <86802c4405072810352d564fd3@mail.gmail.com>
	 <m1ll3q5mx3.fsf@ebiederm.dsl.xmission.com>
	 <86802c4405072913415379c5a4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can we put tsc_sync_wait() back to smp_callin?

So that it will be executed serially and we can get
"synchronized TSC with CPU"?

YH
