Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758370AbWK0QbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758370AbWK0QbU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758368AbWK0QbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:31:20 -0500
Received: from nebensachen.de ([195.225.107.202]:58855 "EHLO nebensachen.de")
	by vger.kernel.org with ESMTP id S1758356AbWK0QbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:31:19 -0500
X-Hashcash: 1:20:061127:linux-kernel@vger.kernel.org::bU9Nx5K0/oX8S2wV:0000000000000000000000000000000003bBL
From: Elias Oltmanns <eo@nebensachen.de>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE: typo in ide-io.c leads to faulty assignment
References: <87k61h3pu2.fsf@denkblock.local>
	<9a8748490611270801g38417047ybcf4304bad9ad673@mail.gmail.com>
X-Hashcash: 1:20:061127:linux-ide@vger.kernel.org::T2xUjalHcYQnIQe3:0000000000000000000000000000000000007Mp4
Mail-Copies-To: nobody
Mail-Followup-To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 27 Nov 2006 17:31:10 +0100
In-Reply-To: <9a8748490611270801g38417047ybcf4304bad9ad673@mail.gmail.com>
	(Jesper Juhl's message of "Mon\, 27 Nov 2006 17\:01\:16 +0100")
Message-ID: <87ac2c4zsh.fsf@denkblock.local>
User-Agent: Gnus/5.110006 (No Gnus v0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> These two lines :
>
> -		args->handler = task_no_data_intr;
> +		args->handler = &task_no_data_intr;
>
> do the same thing.

Thanks for explaining, obviously I got a bit confused.

Sorry for the noise.

Elias
