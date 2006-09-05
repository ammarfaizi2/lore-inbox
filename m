Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWIEVHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWIEVHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWIEVHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:07:52 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:9938 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S1422642AbWIEVHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:07:50 -0400
Message-ID: <44FDE721.2070303@mauve.plus.com>
Date: Tue, 05 Sep 2006 22:07:45 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Maximus <john.maximus@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SDIO functions?
References: <3634de740609050306y38ff56a4t2700e044e11a439f@mail.gmail.com>
In-Reply-To: <3634de740609050306y38ff56a4t2700e044e11a439f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maximus wrote:
> Hi,
>    Just going through the sdio specs and ossman's patch.

>   What are these functions and thier numbers in CMD 53
>   Does that mean an SDIO Card can support upto 8 different functions?.
> 
>   An sdio card can be used as a wlan and camera (if it supports 2
> functions wlan and camera).

Exactly.
It supports one or zero memory functions, and up to 7 (8?) IO functions.

AIUI, there are at the moment cards with memory and wifi.

I have wondered about expander cards - a card with a microcontroller to 
do enumeration and several sockets.
This is quite complex though.
