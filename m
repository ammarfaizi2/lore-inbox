Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVJSEOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVJSEOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 00:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVJSEOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 00:14:39 -0400
Received: from Maxwell.derobert.net ([207.188.193.82]:61896 "EHLO
	Maxwell.derobert.net") by vger.kernel.org with ESMTP
	id S1750792AbVJSEOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 00:14:38 -0400
Message-ID: <4355C812.80103@derobert.net>
Date: Wed, 19 Oct 2005 00:14:10 -0400
From: Anthony DeRobertis <anthony@derobert.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050611)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Horms <horms@verge.net.au>, security@kernel.org, team@security.debian.org,
       334113@bugs.debian.org, linux-kernel@vger.kernel.org,
       Rudolf Polzer <debian-ne@durchnull.de>,
       Alastair McKinstry <mckinstry@debian.org>,
       secure-testing-team@lists.alioth.debian.org
Subject: Re: [Secure-testing-team] Re: kernel allows loadkeys to be used by
 any user, allowing for local root compromise
References: <E1EQofT-0001WP-00@master.debian.org>	<20051018044146.GF23462@verge.net.au> <m37jcakhsm.fsf@defiant.localdomain>
In-Reply-To: <m37jcakhsm.fsf@defiant.localdomain>
X-Enigmail-Version: 0.91.0.0
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAKlBMVEVTAABbAQBsAACAAQCV
 AAC3DwTXPhTrZiLyjiroi133tCn53UX51n/45bb7J7XrAAACZ0lEQVQ4y2WTz07bQBDGlz5BHF6g
 cfoAxeu+QHYd7rDjwD1eK1eq7AbUU6XGVpRroTxBKE8ABs6oKr2itiHv0pldh/zpSJai/WVm55v5
 lgVBsLufFaoT4q8GWwWBGC4VJxBsgjaXqeJRa5MEQRNBLxMupe2KvWk4ELZ5fPxVcB6GYbyHtBm/
 J9AkkGaSf0CWRFjx3YErFRKADJIjUBIURFx2CIQEZKL1eGQ/ApyNVSJFwwOOIAWAdKBktxiKVuhB
 G0E6VhJD8Fjxjm+XzmN59EVy7vrCzwNOhaA3RBA58cux4LlMTy9QoD9/1c7j7rBXDkHU540VSExu
 QGLtjQRGlQzgDMPWRgIB0EouwWq6MYozr2BtU1ImOQH+P0hHmZJ1t+sggTwDSSmbq/UAAJexBQAG
 j9ZolfRbGwD/PHjWJv1TiG2QWioFMtoCvcEzXS5dv2tdAXaLy66FrAPtgKgVrkCqrQZSvi59J3jL
 dD690CtAaAc995mZT+faA29eH7sH7LY0mS/l/e4ijE/YQ2XAXR6LcJkSSjhhi9+GLsdQ9dbR/kPY
 Y4vK6IwA9GufoLe6hxGbz06xX4y8L8hwzsv7irP59VPhARxyT9BRINni/psborOKcym9CgD287sl
 kJdjDzhZGbthTzOrNaR5mXkxnGxzLjirClyf1tbUKrmE41kmIlaVEwKX2ACNmOrkGl89q+6vsFY+
 fTSZA2RMcjh7+DWzNh8V2IIbDN4wJiezxd2VtbZE+X4w+E4zhVLZ4i+CSWFIpAPQc/2xeXVd2MmN
 XQLnvwRH8jK/u5m+FD9w+K4WzuCs0Ab+Ad5UBbueJrnMAAAAAElFTkSuQmCC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:

> Why doesn't the intruder just simulate login process (printing "login: "
> and "Password:")? That's known and used for ages.

Well, you can configure a single vty to only allow logins from admins.
Then you avoid the fake login problem, but not the loadkeys problem
(since that affects all vtys)
