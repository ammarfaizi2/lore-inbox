Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLAR0d>; Fri, 1 Dec 2000 12:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLAR0Y>; Fri, 1 Dec 2000 12:26:24 -0500
Received: from [212.140.94.65] ([212.140.94.65]:15368 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129257AbQLAR0R>;
	Fri, 1 Dec 2000 12:26:17 -0500
Date: Fri, 1 Dec 2000 16:57:20 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "T. Camp" <campt@openmars.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mutliple root devs (take II)
In-Reply-To: <Pine.LNX.4.21.0012010843470.4856-100000@magic.skylab.org>
Message-ID: <Pine.LNX.4.21.0012011655300.1488-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 1 Dec 2000, T. Camp wrote:

> A much cleaner patch prompted after right proper chastisement on the

indeed, much cleaner. But still not perfect.

> +	int root_device_index = 0;

this initialisation is not needed. Just make it 'int root_device_index;'
The kernel will do the right thing for you on boot, trust me.

> +int number_root_devs = 0;

this is not needed either.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
