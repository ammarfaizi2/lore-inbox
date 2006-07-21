Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWGUKcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWGUKcf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 06:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWGUKcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 06:32:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:10597 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161047AbWGUKce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 06:32:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=HCa3xKSpr4Uk6TahVURsWjeip/gQc+DwUviHsqL6gwOfhaawZbKCK2ywVi+xstY+cpdX0Y/9FV6lfvXYOE5DvlWXWYKxAI43oO+Crq7zvWHx75pWyfZwG0A2Br4VmkrGfAz8ELXaTm9U5BWr9zivJp+X0MdSQZSXyKZIO+kicWo=
Message-ID: <84144f020607210332l2ecf4c7ch7fe144e2d8c7764d@mail.gmail.com>
Date: Fri, 21 Jul 2006 13:32:32 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Arthur Othieno" <apgo@patchbomb.org>
Subject: Re: [PATCH] doc: pci_module_init() removal
Cc: gregkh@suse.de, "Richard Knutsson" <ricknu-0@student.ltu.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060719234044.GB8584@krypton>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060719234044.GB8584@krypton>
X-Google-Sender-Auth: bb2f52c88e512cc2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/06, Arthur Othieno <apgo@patchbomb.org> wrote:
> pci_module_init() is deprecated and on it's way out in favor of
> pci_register_driver(). Remove all documentation references to it.

[snip]

> diff --git a/Documentation/PCIEBUS-HOWTO.txt b/Documentation/PCIEBUS-HOWTO.txt
> index c93f42a..7369219 100644
> --- a/Documentation/PCIEBUS-HOWTO.txt
> +++ b/Documentation/PCIEBUS-HOWTO.txt
> @@ -93,7 +93,7 @@ the PCI Express Port Bus driver from loa
>
>  int pcie_port_service_register(struct pcie_port_service_driver *new)
>
> -This API replaces the Linux Driver Model's pci_module_init API. A
> +This API replaces the Linux Driver Model's pci_register_driver API. A

This doesn't look right.
