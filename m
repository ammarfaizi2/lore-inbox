Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVG1Qoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVG1Qoh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVG1Qm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:42:26 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:23958 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261699AbVG1Qkn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:40:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d/kWkk2mlm/eZuIeluyHSaK4BYHO3FEjuI2OjSWmacmsUMnRInSIaTF7k5O3dbdJEXaYuTHm8Y3wRON3YOwV2LrcxkX5256oFxnkv0lkJGpsMveJTCp4WWJ3T/P81WKOGBypQe8TuJiO81DUsHUJo6g8ZTiiV8XWvng4LWepBs0=
Message-ID: <d120d50005072809407a179d7e@mail.gmail.com>
Date: Thu, 28 Jul 2005 11:40:42 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: kernel guide to space (updated)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050728145353.GL11644@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050728145353.GL11644@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> 
> 9. The following is helpful with VIM
>        set cinoptions=(0:0
> 

And this will highlight whitespace damage:

highlight RedundantSpaces ctermbg=red guibg=red 
match RedundantSpaces /\s\+$\| \+\ze\t/

-- 
Dmitry
