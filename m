Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265263AbUHJNxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUHJNxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266258AbUHJNwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:52:16 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:31967 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S265305AbUHJNv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:51:29 -0400
X-Sender-Authentication: net64
Date: Tue, 10 Aug 2004 15:51:26 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mj@ucw.cz, James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk,
       axboe@suse.de, dwmw2@infradead.org, eric@lammerts.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040810155126.7afa6dea.skraw@ithnet.com>
In-Reply-To: <200408101245.i7ACj6EM014024@burner.fokus.fraunhofer.de>
References: <200408101245.i7ACj6EM014024@burner.fokus.fraunhofer.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 14:45:06 +0200 (CEST)
Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> >From: Martin Mares <mj@ucw.cz>
> 
> >> Switching Burn-Proof on will reduce the quality of the CDs.
> 
> >BTW is it true that Burn-Proof reduces the quality exactly in the cases
> >where burning without Burn-Proof would ruin the disk?
> 
> This is why it is silly to tell people that they do not need locked memory
> and raised scheduling priority for CD/DVD writing.

Please, if you don't want to answer the original question, don't post anything.


My answer:
Yes, burn-proof (or however the vendor calls the corresponding feature) saves
your disk where otherwise you run into dead-end. That's what it was meant to
be. When there is no underrun, burn-proof should not do any harm.

Regards,
Stephan
