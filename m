Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292588AbSDIN4C>; Tue, 9 Apr 2002 09:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292870AbSDIN4B>; Tue, 9 Apr 2002 09:56:01 -0400
Received: from zork.zork.net ([66.92.188.166]:61447 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S292588AbSDIN4A>;
	Tue, 9 Apr 2002 09:56:00 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: C++ and the kernel
In-Reply-To: <Pine.LNX.3.95.1020409085537.4291B-100000@chaos.analogic.com>
	<3CB2F3F9.8325AC04@nortelnetworks.com>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Message-Flag: Message text advisory: ARGUMENTUM AD HOMINEM, DISHONOURABLE
 INTENTIONS
X-Mailer: Norman
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 09 Apr 2002 14:55:59 +0100
Message-ID: <6uofgtvuvk.fsf@zork.zork.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Chris Friesen quotation:

> "Richard B. Johnson" wrote:
>> Making code "cleaner" is a matter of perspective.
>> 
>>         class A {
>>         public: void func(char *st) { cout << st << endl; }
>>         };
>>         using A::func;
>>         A a;
>>         a.func("Hello World!");
>> 
>> Is not all that clean. In fact, I'm not sure I have it right. It's
>> easier and clearer to write  puts("Hello World!");
>
> Your example is needlessly complex, and I'm sure you know this.  A more
> realistic comparison would be:
>
> cout << "Hello World!\n";

And of course standard libraries are not available in the kernel, so
you'll most likely end up calling printk anyway in your C++ kernel
code.

-- 
 /////////////////  |                  | The spark of a pin
<sneakums@zork.net> |  (require 'gnu)  | dropping, falling feather-like.
 \\\\\\\\\\\\\\\\\  |                  | There is too much noise.
