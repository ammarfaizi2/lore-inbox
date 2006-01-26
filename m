Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWAZPfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWAZPfS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 10:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWAZPfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 10:35:18 -0500
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:56977 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932364AbWAZPfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 10:35:16 -0500
Message-ID: <BAYC1-PASMTP107043337A760707075E33AE150@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Thu, 26 Jan 2006 10:30:04 -0500
From: sean <seanlkml@sympatico.ca>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de,
       rlrevell@joe-job.com, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060126103004.07e02876.seanlkml@sympatico.ca>
In-Reply-To: <43D8D736.nailE2XB11W3N@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	<43D7A7F4.nailDE92K7TJI@burner>
	<8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
	<43D7B1E7.nailDFJ9MUZ5G@burner>
	<C3FAC4ED-D7B6-45FE-BCC8-DDCE1E8EEC65@mac.com>
	<43D89F23.nailDTH5ZT0IY@burner>
	<20060126104012.GA32206@merlin.emma.line.org>
	<43D8D736.nailE2XB11W3N@burner>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jan 2006 15:36:03.0390 (UTC) FILETIME=[373A35E0:01C6228E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006 15:05:42 +0100
Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> 
> If you open e.g. /dev/cam or /dev/scg?, you open device that is not related
> to a high level service like /dev/hd* and this unfortunately is unable to talk 
> to other devices in the same entity (e.g. ATAPI tapes).
> 
> With /dev/cam or similar you get a single handle for a group of devices that 
> than are addressed via something very similar to dev=b,t,l
> 

So what?   Why is it so important to have just a single handle in this case
as opposed to multiple handles?

Sean
