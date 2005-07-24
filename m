Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVGXTYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVGXTYs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 15:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVGXTYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 15:24:48 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:5780 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261485AbVGXTYn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 15:24:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dOdM1chnyD1DQCfFZF4JUb//9vNVUX7f5UFJSLCrZnLgqfJiq7CuK3r0LURrMvUTpAPixsyNY9a5Vveymd/s7LT12ABCAa6/cIVO/6XP5TVtYCtRCgNtX6k/gXrrA72bMPzQGdtIlJYFGanE7nGmhUi40KkN2gia322PKLyXPR0=
Message-ID: <1e62d13705072412247d6c3413@mail.gmail.com>
Date: Mon, 25 Jul 2005 00:24:41 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: Fawad Lateef <fawadlateef@gmail.com>
To: VASM <vasm85@gmail.com>
Subject: Re: kernel page size explanation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4536bb7305072412011fbeaf59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.SOL.4.58.0507211925170.28852@titan.cfa.harvard.edu>
	 <9a87484905072118207a85970e@mail.gmail.com>
	 <87d5p8aw4h.fsf@amaterasu.srvr.nix>
	 <4536bb7305072412011fbeaf59@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/05, VASM <vasm85@gmail.com> wrote:
> i had one question
> does the linux kernel support only one default page size even if the
> processor on which it is working supports multiple ?
> 

The PAGE_SIZE depends on the architecture and it do supports different
page_sizes depending on the architecture (AFAIK for almost all
supported architectures)

-- 
Fawad Lateef
