Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVC2PEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVC2PEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 10:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVC2PEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 10:04:13 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:7492 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262305AbVC2PEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 10:04:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CfwzXMDYVUmLs/B7ptZqJltUihQ/fSjqQtd+nNMvSTFXMnRnLPugHs7Dfp6SPNycKmi3sSkzmFglneCN3fb8goOpyswFxwhA+k10dwcnOoFj8EV0KnV6ITIuP9fMcHDkxZAUh4J3qnDlzhVPJaaPh3NqQo8ueny6GRjFMBnC6LY=
Message-ID: <d120d500050329070423e3f01@mail.gmail.com>
Date: Tue, 29 Mar 2005 10:04:06 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Romano Giannetti <romanol@upco.es>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, linux-input@atrey.karlin.mff.cuni.cz,
       Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: ALPS touchpad woes with 2.6.12rc1 and rc1-mm3
In-Reply-To: <20050329113042.GA19324@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050329113042.GA19324@pern.dea.icai.upco.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 13:30:42 +0200, Romano Giannetti <romanol@upco.es> wrote:
> Hi all,
> 
>   In the kernels 2.6.12-rc1 and 2.6.12-rc1-mm3 my ALPS touchpad is not
>   recognized by the Xorg driver. The strange thing is that in dmesg ALPS is
>   detected, but then the Xorg driver tell strange things...
> 

Could you please post your /proc/bus/input/devices from 2.6.12-rc1 to
make sure that you are using correct event device. If you have noticed
ALPS now registers 2 input devices. Btw, setting protocol to
"auto-dev" in your X config helps dealing with event devices moving
around.

-- 
Dmitry
