Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVLMSlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVLMSlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbVLMSlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:41:39 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:13916 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030203AbVLMSli convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:41:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y8rBYH7qfpIUC2Vzag7cM8cnAvhpgE4SW9jZNkkQ41bTa9RHnErqBLi1DumAdQoXXH4Pdb6HrjW+nAPPVJazj9ldgMZKYEn9xThl7QzZPkxHrMGHaeBBTUOr264ehV0T+BbpBh80/94KhwB+diIA2bbtFiXiFke0reWfVcc+azs=
Message-ID: <41840b750512131041i5ae5f021h29eed3492bad88ca@mail.gmail.com>
Date: Tue, 13 Dec 2005 20:41:00 +0200
From: Shem Multinymous <multinymous@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tp_smapi conflict with IDE, hdaps
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>,
       Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
In-Reply-To: <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486203.11732.60.camel@localhost.localdomain>
	 <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Shem Multinymous <multinymous@gmail.com> wrote:
> ThinkPad T43 BIOS 1.24, Hitahi HTS726060M9AT00 firmware MH4OA6GA.

Oops, sorry, that's the hard disk. The drive is a Matshita UJ-822S
firmware 1.61 (branded by IBM as "UltraBay Slim DVD Multi-Burner
Plus").

Meanwhile, I found out that with this drive, "hdparm -E" does affect
CD-R discs, but not DVD-R discs. The SMAPI BIOS command affects both.

  Shem
