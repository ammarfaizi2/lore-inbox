Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUCAUYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbUCAUYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:24:36 -0500
Received: from mail.fdk-filmhaus.de ([212.184.83.66]:53222 "EHLO
	mail.fdk-filmhaus.de") by vger.kernel.org with ESMTP
	id S261427AbUCAUYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:24:03 -0500
Message-ID: <32809.213.73.114.194.1078172622.squirrel@mail.fdk-filmhaus.de>
In-Reply-To: <20040301183441.GA29415@redhat.com>
References: <57977.212.184.83.69.1078165110.squirrel@mail.fdk-filmhaus.de>
    <20040301183441.GA29415@redhat.com>
Date: Mon, 1 Mar 2004 21:23:42 +0100 (CET)
Subject: Re: 2.6.2: drm:drm_init Cannot initialize the agpgart module
From: "Christoph Terhechte" <ct@fdk-berlin.de>
To: "Dave Jones" <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, that did it. I was confused, because I didn't need the extra
module with 2.4 series kernels.

> You have a VIA southbridge, but an AMD north bridge (where agpgart lives)
> Try modprobe amd-k7-agp
>
> 		Dave


-- 
Christoph Terhechte <ct@fdk-berlin.de>
International Forum of New Cinema
Potsdamer Strasse 2
D-10785 Berlin
Tel: +49-30-269.55.200
Fax: +49-30-269.55.222

