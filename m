Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVAUPse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVAUPse (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 10:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVAUPse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 10:48:34 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:51308 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262397AbVAUPsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 10:48:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DC3qcKHsQN5BtT54N+My8UvE8nxwk3J4Ygkg3E7CnVNV/jCgqDTgNRR2VEgOUapU+q79sSh2FEd5DTSUe01Omoz1tsXffD0jzxsYOFT3TKQortVT4YkXiBtILU2/eSYFACY2ne9kQnUzzV9JpGnu3KBRc2jEbLGLGsKH1LgB9fs=
Message-ID: <d120d500050121074831087013@mail.gmail.com>
Date: Fri, 21 Jan 2005 10:48:27 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Wiktor <victorjan@poczta.onet.pl>
Subject: Re: AT keyboard dead on 2.6
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41F11F79.3070509@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41F11F79.3070509@poczta.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005 16:27:53 +0100, Wiktor <victorjan@poczta.onet.pl> wrote:
> Hi,
> 
> my AT keyboard is dead on 2.6 series. Tests on other machines proves
> that this is my-hardware-specyfic problem (exacly the same binnary works
> on different mainboards with PS/2 keyboard and another AT keyboard). 2.4
> series works correctly. On 2.6 kernel seems to not hear what keyboard
> wants to tell him (eg. atkbd.reset preforms keyboard reset but reports
> error). Were any hadrware-handling changes made since 2.4? If so, how to
> undo them and make keyboard alive? I'm grateful for any help.
> 

Hi,

What kernel version are you using? Have you tried 2.6.8.1? - it looks
like changes in 2.6.9-rc2-bk3 caused problems on some hardware.

-- 
Dmitry
