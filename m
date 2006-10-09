Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWJIMMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWJIMMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWJIMMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:12:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:60338 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751852AbWJIMMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:12:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VcesftMizB9u+icI/Icok60LtLkE5yAKQY9yU7nPTcYES/T8xhVhimbcKub+YKtKAC8T9Uq+7OlpIgtkvvzMbKqULH8UDP6m0zbJLjVDUKbvUJZQJsPeWyMPzIPzEhGLHLtPaWKVc+vzCc4mjU9XZvl4QBOpiri7l1QTfTlqasg=
Message-ID: <41840b750610090512j42588537u16994de23d22cf38@mail.gmail.com>
Date: Mon, 9 Oct 2006 14:12:18 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [Hdaps-devel] Debugging strange system lockups possibly triggered by ATA commands
In-Reply-To: <877iz9ohbe.fsf@denkblock.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <877iz9ohbe.fsf@denkblock.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elias,

On 10/9/06, Elias Oltmanns <oltmanns@uni-bonn.de> wrote:

> A slightly stripped version of the patch is available too, which has
> been verified to trigger the described problem in exactly the same way
> as the original but lacks the IDLE IMMEDIATE feature (leaving the
> STANDBY IMMEDIATE option only) in order to make it (hopefully) more
> readable and easier to understand.

What happens if you strip away *all* the head parking code, leaving
only the queue freeze code? Conversely, what happens if you issue the
head park command but don't freeze the queue?

  Shem
