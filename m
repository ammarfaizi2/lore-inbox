Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289342AbSBEHoD>; Tue, 5 Feb 2002 02:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289346AbSBEHnu>; Tue, 5 Feb 2002 02:43:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45581 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289342AbSBEHnf>;
	Tue, 5 Feb 2002 02:43:35 -0500
Date: Tue, 5 Feb 2002 08:43:15 +0100
From: Jens Axboe <axboe@suse.de>
To: hugang <gang_hu@soul.com.cn>
Cc: andersen@codepoet.org, calin@ajvar.org, linux-kernel@vger.kernel.org
Subject: Re: Asynchronous CDROM Events in Userland
Message-ID: <20020205084315.C2087@suse.de>
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu> <20020204070414.GA19268@codepoet.org> <20020204085712.O29553@suse.de> <20020204220503.6799df5b.gang_hu@soul.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020204220503.6799df5b.gang_hu@soul.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04 2002, hugang wrote:
> Now it can work!

?

The first 4 bytes is the event header, then followed by the media event
descriptor. The first byte of that is the media event (well bit 0-3
anyways). You are instead returning the media status byte.

-- 
Jens Axboe

