Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWBQNJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWBQNJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWBQNJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:09:19 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:1679 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932377AbWBQNJS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:09:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c58q2CaO9tbDMFr3lMMG/Bg6HOfoW7owml7nTvr06bMGZ8LU2NWnD+XhUb9j29dNLB56sEQx4jgw6Kp+U5BiDXErk+tzTMlhkZLpTn/BQysZTNtrxCxOyyARVPZWj8RFfraPfGEuso/2vcFBRlDIDD4Xw9xb+PWtfFPptzarshw=
Message-ID: <7c3341450602170509l122247f8y@mail.gmail.com>
Date: Fri, 17 Feb 2006 13:09:17 +0000
From: Nick Warne <nick@linicks.net>
Reply-To: Nick Warne <nick@linicks.net>
To: Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: [HWMON] Add LM82 support
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       info-linux@ldcmail.amd.com, Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20060216175930.GE20157@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060216175930.GE20157@cosmic.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'
>                 if (kind <= 0) { /* identification failed */
> @@ -296,10 +318,15 @@ static int lm83_detect(struct i2c_adapte
>         if (kind == lm83) {
>                 name = "lm83";
>         }
> +       else if (kind = lm82) {
> +               name = "lm82";
> +       }

Is that a '=' typo in the 'else if' there?

Nick
