Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbSJ2SfA>; Tue, 29 Oct 2002 13:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSJ2SfA>; Tue, 29 Oct 2002 13:35:00 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:10115 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262046AbSJ2Se7> convert rfc822-to-8bit; Tue, 29 Oct 2002 13:34:59 -0500
From: christophe varoqui <christophe.varoqui@free.fr>
Organization: devoteam
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [RFC]partitions through device-mapper
Date: Tue, 29 Oct 2002 20:41:10 +0200
User-Agent: KMail/1.4.7
Cc: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0210290916360.9171-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0210290916360.9171-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210291941.10659.christophe.varoqui@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a) devmapper is merged, but it sure as hell is not mandatory
>
let me argue that if I decide to hand my system FS to the device-mapper I 
wouldn't want the current partition code to be mandatory either (devil's 
advocate speaking)

> b) relying on the hotplug working right means living dangerously.  Right
> now that code is brittle in the best case.
>
> c) all existing races in overlapping attach/detach (and $DEITY witness,
> there's a plenty) immediately become much wider [OK, that's part of
> (b), actully]
>
> IOW, right now the thing is nowhere near being ready for such use.

point taken.
But, the question remains : do we want to get there in the end ?
(question from the time-and-effort-worthy? departement)
