Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVDDVSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVDDVSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVDDVRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:17:20 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:16596 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261402AbVDDVCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:02:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lstHLKHsfc+ry1XKNb9W+yDpKPYN3qJ3ySJT/PssAwY7zN626gPVjZdKsE4boKeyKjkFjdUxaB60SlnwKLB5v+j9bLgNOnYJ3g4kRjRYsYNmoWrJRXbfaJKmzZlZEH6j0jSHd9AC6b02+FALuIuNNhN53/9oYkRVSFkPb+Zk4u0=
Message-ID: <d120d500050404140253a77ab8@mail.gmail.com>
Date: Mon, 4 Apr 2005 16:02:36 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jaco Kroon <jaco@kroon.co.za>
Subject: Re: i8042 controller on Toshiba Satellite P10 notebook - patch
Cc: linux-kernel@vger.kernel.org, Sebastian Piechocki <sebekpi@poczta.onet.pl>
In-Reply-To: <4251A515.8040802@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <425166F9.1040800@kroon.co.za>
	 <d120d5000504040954354fb3fa@mail.gmail.com>
	 <42517442.20602@kroon.co.za>
	 <d120d500050404110374fe9deb@mail.gmail.com>
	 <4251A515.8040802@kroon.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 4, 2005 3:35 PM, Jaco Kroon <jaco@kroon.co.za> wrote:
> 
> As for loading the modules i8042, atkbd and psmouse (in that order):
> black void of death.
> 

Hmm.. remind me, if you boot with usb-handoff does it switch the i8042
into active multiplexing mode (you get 4 AUX serio ports)?

-- 
Dmitry
