Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423666AbWKHUpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423666AbWKHUpI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423688AbWKHUpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:45:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:52799 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423666AbWKHUpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:45:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Wo0LTtDCmwf8tTETHxSFVj0XaklRF715g/24t1ibJyjSByWSlfqVpLseQ6NkI6HpTt7zkHqI/lCnlA5oAoZgaMGhpajm+KzggNVJazra07f/UriGJp9266l/KP0HYWjVpzx3/ZuZdspUv7z6MQ0J0xZsPOG3ydRUGPlPbAmBQXo=
Message-ID: <d120d5000611081244r74118c50g1dfc998ccb076659@mail.gmail.com>
Date: Wed, 8 Nov 2006 15:44:58 -0500
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: "Sergey Vlasov" <vsu@altlinux.ru>
Subject: Re: [PATCH] Input: psmouse - fix attribute access on 64-bit systems
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       stable@kernel.org
In-Reply-To: <11629116333762-git-send-email-vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11629116333762-git-send-email-vsu@altlinux.ru>
X-Google-Sender-Auth: d556525947f2eb5a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Sergey Vlasov <vsu@altlinux.ru> wrote:
> psmouse_show_int_attr() and psmouse_set_int_attr() were accessing
> unsigned int fields as unsigned long, which gave garbage on x86_64.
>
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

Will apply, thank you Sergey.

-- 
Dmitry
