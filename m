Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWAGB0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWAGB0f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWAGB0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:26:35 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:63661 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030305AbWAGB0f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:26:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ERyRZS99ZL837YBz3IxuKMU2i5PRIzWq2LbUq6/XGXfOqveneJ8/RnH34SOZETQTwbl883r2w5G/KJNjdv/TmQFB8izgFoGRNiPJ700jq1t6lAJctvVYUIcb2l71NIM+4yP8M5ZM8JfDvVHa7qCBN68b7UGZQMwGpEuN9+GJV3s=
Date: Sat, 7 Jan 2006 02:26:25 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] scsi_transport_spi.c: make print_nego() static
Message-Id: <20060107022625.e2c1dc0f.diegocg@gmail.com>
In-Reply-To: <20060105223918.GM12313@stusta.de>
References: <20060105223918.GM12313@stusta.de>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 5 Jan 2006 23:39:18 +0100,
Adrian Bunk <bunk@stusta.de> escribió:

> This patch makes a needlessly global function static.


Ok, so this is probably a stupid question and it may have been already
discussed but.....

Isn't possible that GCC would/will add an extension (a useful one) similar
to the visibility thing that c++ got in GCC 4.x? It somewhat weird
that we need to mark things static, instead of the contrary (marking
as global the things you want to make global, would be much nicer since
the functions made global would be the "API")
