Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVFHICW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVFHICW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 04:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVFHICW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 04:02:22 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:40148 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262135AbVFHICQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 04:02:16 -0400
Message-ID: <42A6A604.4020007@ens-lyon.org>
Date: Wed, 08 Jun 2005 10:02:12 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
References: <42A0D88E.7070406@pobox.com>	<20050603163843.1cf5045d.akpm@osdl.org>	<42A0F05A.8010901@ens-lyon.org> <20050603182125.3735f0c7.akpm@osdl.org> <42A5B27F.60204@ens-lyon.org> <42A5C2F9.3010809@worldonline.fr>
In-Reply-To: <42A5C2F9.3010809@worldonline.fr>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sylvain Meyer a écrit :
>        Hi Brice,
> 
>    What is your X configuration ? The default parameters are ok for a
> VideoRam parameter up to 32MB. Could you check two things, please ?
>    - First, could you set VideoRam to 32MB in your X conf.
>    - Second, could you set it to 64MB and use a voffset=64 parameter for
> intelfb.
> 
> Thanks
> Sylvain

"First" works.

"Second" doesn't:
intelfb says that the initial video mode is 640x400-8@69. This might
be correct (I did not count :)).
But during the boot, the display of messages seems to be shifted upwards
(the shift is about 3 or 4 text lines).
And switching from X to fbcon is still broken, but not as previously
(dirty vertical lines without text). Now, the 3 bottom pixel lines of
the last text line of the display ("host login:") are shown regularly
everywhere on the screen.

Brice
