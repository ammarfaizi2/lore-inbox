Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbTFTUpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 16:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTFTUpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 16:45:21 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:62907 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S264632AbTFTUpT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 16:45:19 -0400
Message-ID: <3EF375BA.80901@cox.net>
Date: Fri, 20 Jun 2003 13:59:38 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5a) Gecko/20030609
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Stephan von Krawczynski <skraw@ithnet.com>, stoffel@lucent.com,
       gibbs@scsiguy.com, linux-kernel@vger.kernel.org, willy@w.ods.org,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <41560000.1055306361@caspian.scsiguy.com> <20030611222346.0a26729e.skraw@ithnet.com> <16103.39056.810025.975744@gargle.gargle.HOWL> <20030613114531.2b7235e7.skraw@ithnet.com> <Pine.LNX.4.55L.0306171744280.10802@freak.distro.conectiva> <20030618130533.1f2d7205.skraw@ithnet.com> <Pine.LNX.4.55L.0306201658210.2607@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0306201658210.2607@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> So the data is intact when it arrives on the 3ware and gets corrupted
> on the write to the tape?
> 

Actually, without another copy of the data on a different system to verify it 
with, you can't know that for sure. It could easily be getting to the tape (the 
actual media) just fine, but then get corrupted during the verify readback.


