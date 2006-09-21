Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWIUPko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWIUPko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 11:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWIUPko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 11:40:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:62563 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751284AbWIUPkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 11:40:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=tVSMn2JGernSSs7nwlVhkbWwFl+3+KEPbnPJGfmeIKy9DPdP8rSWWhwody1qvREBVGw3khs1Ep9eBHAB8lNl9R5vZHTf0QtKgdmGb9HQew8pxpWMsLPXNDLlfVcs/7eLsWStxn6RchH6lDP8iu2DPf90bRLeD1Gusivs0rp8gqg=
Message-ID: <d120d5000609210840v3bbc2758t66cef4ff7b499089@mail.gmail.com>
Date: Thu, 21 Sep 2006 11:40:40 -0400
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: "Adam Buchbinder" <adam.buchbinder@gmail.com>
Subject: Re: [linux-usb-devel] [PATCH 2.6.17.11] xpad: dance pad support
Cc: greg@kroah.com, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <4512AD76.4070005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4512AD76.4070005@gmail.com>
X-Google-Sender-Auth: 7dcf02c0586e5029
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/06, Adam Buchbinder <adam.buchbinder@gmail.com> wrote:
> +
> +static int dpad_to_buttons = 0;
> +module_param(dpad_to_buttons, bool, S_IRUGO);
> +MODULE_PARM_DESC(dpad_to_buttons, "Map D-PAD to buttons rather than axes for unknown pads");

There is no need to initialize dpad_to_buttons to 0, it already is.
Oherwise you may add:

Acked-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry
