Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWCOOac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWCOOac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 09:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWCOOac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 09:30:32 -0500
Received: from cernmx08.cern.ch ([137.138.166.172]:58823 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1751271AbWCOOab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 09:30:31 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding;
	b=Q+NcVXPKhPFHTIJJoHt/XO77n8u/az/to3FcJ31OmKNrTCgUPu/fPiHFPLysHI6lmvx1oc4MJZVASbA9577er5Aih71wgb1ih1OFVNnaoPy1PUjG6lZ2cKbGDYHIpxwq;
Keywords: CERN SpamKiller Note: -50 Charset: west-latin
X-Filter: CERNMX08 CERN MX v2.0 051012.1312 Release
Message-ID: <44182505.3090604@cern.ch>
Date: Wed, 15 Mar 2006 15:30:29 +0100
From: Jiri Tyr <jiri.tyr@cern.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060128)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sami Farin <7atbggg02@sneakemail.com>
CC: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
References: <440C5672.7000009@cern.ch> <200603061656.18846.duncan.sands@math.u-psud.fr> <440D7384.5030307@cern.ch> <200603071332.19614.baldrick@free.fr> <4417D4ED.6010808@cern.ch> <20060315142148.GD20607@m.safari.iki.fi>
In-Reply-To: <20060315142148.GD20607@m.safari.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2006 14:30:26.0618 (UTC) FILETIME=[008E79A0:01C6483D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Farin wrote:

>I didn't change xawtv configs, and
>1) with the patch system did not crash
>2) without the patch system crashed
>
>draw your own conclusions.
>  
>
OK, I will wait for the change in the kernel.

>and
>3) if xawtv is able to crash kernel, kernel needs fixing.
>  
>
It is strange, but manipulation with the channel list (longer then 15 
items) in XAWTV made not only solide lock of the kernel, but also 
sometimes only crash of the USB driver or PS2 keyboard driver. I think 
there is (was - not with your patch?) something wrong in the kernel. 
Maybe some memory problem.

Jiri
