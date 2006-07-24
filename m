Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWGXM20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWGXM20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 08:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWGXM20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 08:28:26 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:49610 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932130AbWGXM2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 08:28:25 -0400
Date: Mon, 24 Jul 2006 14:28:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] kconfig/lxdialog: add bluetitle color scheme
In-Reply-To: <20060724113914.GD22806@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0607241425440.6762@scrub.home>
References: <20060724113641.GA22806@mars.ravnborg.org>
 <20060724113914.GD22806@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 Jul 2006, Sam Ravnborg wrote:

> +static void set_bluetitle_theme(void)
> +{
> +	DLG_MODIFY(title, COLOR_BLUE, COLOR_WHITE,  true);
> +	DLG_MODIFY(button_label_active, COLOR_BLUE, COLOR_BLUE,   true);
> +	DLG_MODIFY(searchbox_title,     COLOR_BLUE, COLOR_WHITE,  true);
> +	DLG_MODIFY(position_indicator,  COLOR_BLUE, COLOR_WHITE,  true);
> +	DLG_MODIFY(tag,                 COLOR_BLUE, COLOR_WHITE,  true);
> +	DLG_MODIFY(tag_selected,        COLOR_BLUE, COLOR_BLUE,   true);
> +	DLG_MODIFY(tag_key,             COLOR_BLUE, COLOR_WHITE,  true);
> +	DLG_MODIFY(tag_key_selected,    COLOR_BLUE, COLOR_BLUE,   true);
> +}

In general I would like to see this one become the default, as yellow on 
white is really terrible, but this one needs fixing too - blue on blue is 
not really readable either. :)

bye, Roman
