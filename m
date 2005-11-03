Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbVKCEZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbVKCEZG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVKCEZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:25:06 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:38816 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030307AbVKCEZF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:25:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qzl6lwa8sGMjEpKG7YVw0n2ZGltwSKk5Q1kUtnJWvnlKj+ag0jP+9SfVKE2yPAC4peuOPhoFoupfZD6CEjR2YCacu8iWZ+xFIxqahQhzhzIljk409GY2CvxCXw0cpQCuPUS4eMQy9td41/QBTmOODDsWmP8fkmZjyZui3qOLjtY=
Message-ID: <39e6f6c70511022025x17d14571rf306f2b926a56efb@mail.gmail.com>
Date: Thu, 3 Nov 2005 02:25:04 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Thomas Graf <tgraf@suug.ch>
Subject: Re: [PKT_SCHED]: Rework QoS and/or fair queueing configuration
Cc: bunk@stusta.de, jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20051101141302.GM23537@postel.suug.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0510280902470.6910@yvahk01.tjqt.qr>
	 <20051031102621.GF8009@stusta.de>
	 <20051031132729.GK23537@postel.suug.ch>
	 <20051101141302.GM23537@postel.suug.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Thomas Graf <tgraf@suug.ch> wrote:
>
> Make "QoS and/or fair queueing" have its own menu, it's too big to be
> inlined into "Network options". Remove the obsolete NET_QOS option.
> Automatically select NET_CLS if needed. Do the same for NET_ESTIMATOR
> but allow it to be selected manually for statistical purposes. Add
> comments to separate queueing from classification. Fix dependencies
> and ordering of classifiers. Improve descriptions/help texts and
> remove outdated pieces.
>
> Signed-off-by: Thomas Graf <tgraf@suug.ch>

Thanks, applied.
