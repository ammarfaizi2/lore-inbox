Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423922AbWKABUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423922AbWKABUg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423923AbWKABUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:20:36 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:32723 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1423922AbWKABUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:20:34 -0500
Message-ID: <4547F65F.4050500@pobox.com>
Date: Tue, 31 Oct 2006 20:20:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       linux-netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH] n2: fix confusing error code
References: <20061028184712.GG9973@localhost>
In-Reply-To: <20061028184712.GG9973@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita wrote:
> modprobe n2 with no parameters or no such devices
> will get confusing error message.
> 
> # modprobe n2
> ...  Kernel does not have module support
> 
> This patch replaces return code from -ENOSYS to -EINVAL.
> 
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

applied


