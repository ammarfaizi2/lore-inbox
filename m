Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752824AbVHGVkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbVHGVkz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbVHGVkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:40:55 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:42034 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752823AbVHGVky convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:40:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kdt4OFj+HPgKst2Kr5Etz1GX5sOiZVdPbH75LD2yVvagJIcbRpeOvGVtL1oNHELOiVO2rtQk0mpSVpb/CqWVCwlAOjWsdXeyWGqVw+J9lptuH8iVsbQAdTcl4sAPkE1Bh7GmpX4aPB1Imm7pzYbv2q9HjupfBgBeTwx5vTbw+n8=
Message-ID: <7aaed09105080714402bcbddc6@mail.gmail.com>
Date: Sun, 7 Aug 2005 23:40:53 +0200
From: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
To: Patrick McHardy <kaber@trash.net>
Subject: Re: 2.6.13-rc4-mm1: iptables DROP crashes the computer
Cc: Adrian Bunk <bunk@stusta.de>, linux <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org,
       discuss@x86-64.org
In-Reply-To: <42F65513.3080409@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <7aaed091050807100843454603@mail.gmail.com>
	 <7aaed09105080710121bba1b5b@mail.gmail.com>
	 <20050807172333.GF3513@stusta.de> <42F65513.3080409@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/05, Patrick McHardy <kaber@trash.net> wrote:
> Could be related to the refcnt underflow with conntrack event
> notifications enabled. If you have CONFIG_IP_NF_CONNTRACK_EVENTS
> enabled please try this patch.
> 

I can confirm that that patch solved my problems, thank you :)

-- 
Mvh / Best regards
Espen Fjellvær Olsen
espenfjo@gmail.com
Norway
