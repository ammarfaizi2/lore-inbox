Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWJWRPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWJWRPM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWJWRPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:15:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:33050 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964973AbWJWRPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:15:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=epXyt3BewuzxtZ4ZmyKjyhXLzIa5bodvqKKEqfUwzY7cBB8MVOZLaR1CSaMK+lFPNXMvwKIVEUfXJovYa7eIX7hI5/K3mQ4XtxkMxYaGtKBavwVnaB+bh4Dk9weRFLhfVn/n7LlQhPR7pcWHyPoZznwvZ8UrkZ9yYtDaW97Fp6k=
Message-ID: <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>
Date: Mon, 23 Oct 2006 19:15:07 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE85B.2080702@innova-card.com>
	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Miguel Ojeda <maxextreme@gmail.com> wrote:
> Yes, we are sure. AFAIK there is no need to lock when it is a fbdev.
> The older version were "alone" drivers: they needed to lock because
> they used fops and they exported functions.
>

ok, so no other driver than fb could use 'cfag12864b_buffer'. Maybe
I'm missing something but why did you split your fb driver into
cfag12864b.c and cfag12864fb.c ?

BTW, 'cfag12864b_cache' could have been static...

                Franck
