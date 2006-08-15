Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbWHOP77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWHOP77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbWHOP77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:59:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:43650 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965102AbWHOP77 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:59:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=dv5oMGNONcwzpOrWCyyK7YPXXnVjFMppLDqFjcSdIlfczV6mvk2bb2fF3gHeHyhZDVLMY1aXu8iqtSeikmti2NdfLwhvKS2y7ri7cypia7HXOQD85TC7weVWNJAkfZ8LvrLcYdDs2P8WOSOMgLSAkhBtwLqETZDE+ZIxlRUVEQU=
Date: Tue, 15 Aug 2006 17:59:33 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com, akpm@osdl.org,
       dmccr@us.ibm.com
Subject: Re: Shared page tables patch... some results
Message-Id: <20060815175933.3e284567.diegocg@gmail.com>
In-Reply-To: <1155638047.3011.96.camel@laptopd505.fenrus.org>
References: <1155638047.3011.96.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 15 Aug 2006 12:34:07 +0200,
Arjan van de Ven <arjan@infradead.org> escribió:

> Just booting into runlevel 5 and logging into gnome (without starting
> any apps) gets a sharing of 1284 pte pages! This means that five
> megabytes (!!) of memory is saved, and countless pagefaults are avoided.

It's possible to get the patch to test it? (saving memory is one of those
things that makes people want to try patches ;) It'd be interesting to see
how this affects to other (mine) environments. 
