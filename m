Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWGUSxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWGUSxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWGUSxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 14:53:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:21724 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750876AbWGUSxf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 14:53:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YK5+VGuNe6PAap0f7dmE8GLOHDj3txeWXLzJAIzYA0H8o2IETFBNg5BiRQd5ZntjBex0YbR4RFXLwN7c96+7NrzZ1MZW/qHnmwXio/IgdlyTiIZjKxugi3UEbm4f+PF/hqnCQSrXvUFU8M8SiIY3tSzjGf50hz52fxCAyVxEmSc=
Message-ID: <d120d5000607211153p541a56bbo2f121dd9aa41743d@mail.gmail.com>
Date: Fri, 21 Jul 2006 14:53:34 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "=?ISO-8859-1?Q?Magnus_Vigerl=F6f?=" <wigge@bigfoot.com>
Subject: Re: input: Oops when unplugging opened Wacom USB device
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <200607212029.23617.wigge@bigfoot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200607212029.23617.wigge@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/06, Magnus Vigerlöf <wigge@bigfoot.com> wrote:
>
> Does somebody knows the reason for the lack of locking in this part
> of the code? The code is similar and the problems may be the same
> in joydev.c and tsdev.c as well.
>

Ahem, well, just lack of time I suppose. I am starting adding some
locking to the input core, once its done we can work on locking in
handlers.

-- 
Dmitry
