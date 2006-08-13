Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWHMJbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWHMJbm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 05:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWHMJbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 05:31:42 -0400
Received: from rooties.de ([83.246.114.58]:41144 "EHLO rooties.de")
	by vger.kernel.org with ESMTP id S1750863AbWHMJbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 05:31:42 -0400
From: Daniel <damage@rooties.de>
Subject: Re: debug prism wlan
Date: Sun, 13 Aug 2006 11:31:40 +0000
User-Agent: KMail/1.9.1
References: <6.1.1.1.2.20060813071741.02ae87e0@192.168.6.12>
In-Reply-To: <6.1.1.1.2.20060813071741.02ae87e0@192.168.6.12>
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Message-Id: <200608131131.40493.damage@rooties.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 13. August 2006 05:20 schrieb Roger While:
> Alistair John wrote:
>  > Daniel wrote:
>  >> Hey, that did it! But now I am a liddle confused. It worked fine
>  >> before. Why does it not work while interface is not up?
>  >
>  > I'm not sure, but I think you've just been lucky.
>  > I've had this problem even before prism54 was merged.
>  > Some in-tree drivers won't upload the firmware until you ifconfig
>  > up them, which obviously means they won't respond adequately
>  > to the wireless extension requests. Maybe a bug?
>
> Nope, no bug. It allows the driver to be built non-modular.
> When non-modular, the resources are not available,
> at boot time, to load the firmware.
>

Hi, I noticed that you can't set the channel _before_ setting an essid. Is 
this behavior correct?

Daniel
