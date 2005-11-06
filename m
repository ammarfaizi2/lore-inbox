Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVKFALn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVKFALn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVKFALn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:11:43 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:63239 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932230AbVKFALm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:11:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=jTVWtcIhjysu5jH6ghHQ/pI3UKBpfd/vKEoQ1jTFFx5KerqRfh63CoIXDOYlDtBN1IQEzsKsq1fNI/PpROMR4zi8j5+pXysYzLa4LSP7QTkOQbzGiJBBV+lf2HbtbWUTUWehsjZUeAr7BqPm+0lST1pmYQGeqOGo+C644MCkH2I=
Message-ID: <436D4A36.70606@gmail.com>
Date: Sun, 06 Nov 2005 08:11:34 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Hanselmann <linux-kernel@hansmi.ch>
CC: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] Framebuffer mode required for PowerBook Titanium
References: <20051105234938.GA18608@hansmi.ch>
In-Reply-To: <20051105234938.GA18608@hansmi.ch>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hanselmann wrote:
> This patch adds the framebuffer mode required for an Apple PowerBook G4
> Titanium.
> 

Does booting with video=xxxfb:1152x768M@60 work?  If it does, I would prefer
that we avoid adding more entries to the global mode database.

Tony
