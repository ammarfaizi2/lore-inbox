Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWGKN2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWGKN2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWGKN2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:28:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:45198 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750702AbWGKN2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:28:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MxZDXoJZq4k+PmUUVq77a6H2mlGgbRBBiznIsGzL4BnvnFZAruwqph5J5l7NglGJ/ckp+FASEKUVayyxL4R+K01+hICyoHpe1fHAAE2mZuNlnAKR5RwE6A1nru5HiGMqEUdooQTuEHMZXMm5FlWpqkVWYw/tcwFN0e5bIncHoUo=
Message-ID: <b0943d9e0607110628w60a436f7t449714eb4a3200ca@mail.gmail.com>
Date: Tue, 11 Jul 2006 14:28:11 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607110617g36f7123dm2b5f0e88b10cbcaa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
	 <b0943d9e0607110556v50185b9i5443dabedba46152@mail.gmail.com>
	 <6bffcb0e0607110617g36f7123dm2b5f0e88b10cbcaa@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> With gcc 3.4 it build.

Could you try with CONFIG_DEBUG_KEEP_INIT=y and gcc-3.4? It seems to
work OK for me. Maybe I miss something but just defining an empty
__init shouldn't cause problems.

Thanks.

-- 
Catalin
