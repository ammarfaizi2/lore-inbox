Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVDEUq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVDEUq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVDEUpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:45:11 -0400
Received: from quark.didntduck.org ([69.55.226.66]:52927 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262000AbVDEUku
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:40:50 -0400
Message-ID: <4252F7F8.9030903@didntduck.org>
Date: Tue, 05 Apr 2005 16:41:28 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Harkes <jaharkes@cs.cmu.edu>
CC: Greg KH <greg@kroah.com>, Sam Ravnborg <sam@ravnborg.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/5] Hotplug firmware loader for Keyspan usb-serial driver
References: <20050405193859.506836000@delft.aura.cs.cmu.edu> <20050405194446.040549000@delft.aura.cs.cmu.edu>
In-Reply-To: <20050405194446.040549000@delft.aura.cs.cmu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes wrote:
> A simple Intel HEX format parser/loader.

...

> +static int __init no_init(void)
> +{
> +	return 0;
> +}
> +
> +static void __exit no_exit(void)
> +{
> +}
> +
> +module_init(no_init);
> +module_exit(no_exit);

module_init/exit are not needed if both are simply stubs.

--
				Brian Gerst
