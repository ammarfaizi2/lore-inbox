Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbQLGTpW>; Thu, 7 Dec 2000 14:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130696AbQLGTpM>; Thu, 7 Dec 2000 14:45:12 -0500
Received: from wan0.spacs.k12.wi.us ([207.227.54.9]:15626 "EHLO
	spacs1.spacs.k12.wi.us") by vger.kernel.org with ESMTP
	id <S129669AbQLGTo5>; Thu, 7 Dec 2000 14:44:57 -0500
Date: Thu, 7 Dec 2000 13:29:23 -0600 (CST)
From: jschlst <jschlst@turbolinux.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, jschlst@turbolinux.com
Subject: [PATCH] SMC Tokenring driver update
Message-ID: <Pine.LNX.4.20.0012071322470.32333-101000@spacs1.spacs.k12.wi.us>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-472940234-194371071-976217363=:32333"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---472940234-194371071-976217363=:32333
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello Linus,
I have attached a small patch that updates the SMC Tokenring driver to a
more stable version. It is against kernel 2.4.0-test12-pre7, but should
apply cleanly to any kernel as it only touches smctr.c

- Fixes a timing problem in smctr_wait_cmd().
- Added enhanced error reporting and detection.
- Fixed problem with card detection when io/irq/mem are specified.

Thanks.
Jay Schulist
jschlst@turbolinux.com

---472940234-194371071-976217363=:32333
Content-Type: APPLICATION/x-gzip; name="smctr-2.4.0-test12-pre7.diff.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.20.0012071329230.32333@spacs1.spacs.k12.wi.us>
Content-Description: 
Content-Disposition: attachment; filename="smctr-2.4.0-test12-pre7.diff.gz"

H4sICGPqLzoCA3NtY3RyLTIuNC4wLXRlc3QxMi1wcmU3LmRpZmYA7Vvpd+JG
Ev9s/xWV7MssmEsSiMMezw42TEJibC8wyWSPpydEY5QREmlJPnbi/O1b1RIg
CYljnGz2Q3jPM0bqrq6u81fV7Yk5nUKJ+9dQuTf5nWlXLNP2H0tKuVaWSh5z
PVmpTLh5z7hbsZlX8ZyPzOamfVdx54bHywZUfJdXXG4EM7cPPi6VSp+90lHf
seHG8ECug6ycqs1TVQZFkqTjQqFwEBtHo5kPHWYANECWT2utFaW3b6HUKDah
QP+8fXsMcALgTMGbMfj6+j3c+mPLNODKNJjtsiKYtuHwhcN1j01gxjgzbRg/
AWdT/N02WJkoBFRGM9OFCbvHqRBwBw8O/+jCg+nNxAJTx7KcB+QThv1L0Cf6
wsMtnB6XaDp9SuLFiLZzqfMJdC3TY/g815RldZTfMbDShv5lOxxcaeePC/vR
LYIxMxcuNBW1ojZru+YllonNbuHslUCGjs8NlnPzp8H3oyS5Yee7stCIXC/K
ChTov7VW+rppe/jD+JoEwLdDCD/f6k8wNGa+ZboevP7JNWaW6731fD52hImU
DWf+RnBD+7mc6fYdQ2GHm5MaskQWAavPkvI78xF1rYNnzklVC+6MLTZHSwBh
XdqDbnqaMZ/k8mdrSWV92pbroKYnguLY9GDucDQP0zW4ufDQSIBx7nCYu3du
OcKbso23JUvCsCbMY4ZHnOpgkFTpKVE6ws/cmfgWA9OpmPznyhznuAtmmFOT
TcRqoeU6MHFWEpbL0PctzzR0lKvrL9D6PWHmlWM4Lrmejq/AcGx8a8x0Difk
hya67jl8GfrfKdzLZRnkilzBXaC/pGvnX/aXZ6kUaR+2PmcrkjiusG3l2MI1
aFQw1uxcubBl5cjCcAx/MacTNoX+Tef9VZe+2oblTxi8DmJRIOXy7E1gzFKj
2EBjlqvFujDmcBm05tCCJsxwJkybmnz+oHP0EI/7GPYwlGlh/DjB/9G8Uqaa
ro661+Q6GtPnTAyjjobPLM31nG3Ll3ZS4fr8c5gYm4aGT7dMPYbKCXTJ5kik
itwqtqCgKDWUrIgP4SedQBE0zcckwh81YsF3VxQHRHFzW7gNDa1giqHf0yhV
HbIpmoye5fCnHVOX6/q2a97Z6MdEQ0NBmCtSTJ9oGII1Y/bR9ec5GmA6GD54
+srGPY680xZ6th6K0G9fat90250ubp7Pp8W19AIpnWCG48zS0RYyVyEe919A
qKxKuioo1UaWF3DmIqXQkg4SOEpZ56ioR9w9JohMxtwZhi742Wc+SyeEUTO0
EJLjIY7AnZdYzKM2RY2xXfY/XNp/XamTMOtKsyhLMQdIfsZoQh/F/OQHwzmD
HzoiaxPkyPgEHGJEYxZFXzGcYiUmE3Oa8xalN+zR4zpaxNSBV3D5Te9WG3S/
1/rt4XeEHHZ80sgjmrqHD11aJWsas1z2EuIdiuOHywyDvo6p8FQooak0iugu
hWZVCU36c+PzMXxaKyAyxnIM3YITb4Hc5zaf53Fu6c0CoeXZejr6cBM4Plg/
CvW0jNFj34Xzc7h4P9R6w7Zc10Y/3nY3DeDVK8jF5k0t/c5FFb+7GVx2O7ij
i95IwxTYzRM5KZ9f0/i0SY7jHkx7nBM8j9H2NApjUICrdnuQP9uc4PjeOJfj
uOCvNETrd/tyvXt9kS/CThrPuP31ygxzvQ05ifzoGbUklFeXigpCzKaqhsrL
HP6irHdcishiHb5RGPFNbNcg+v47kyMoCVeGIL8As8U3NK2ySGRJYYeLFaA/
jMlHyPZXfEhSvUAR8yIkx8ZWv3YeVmujzQvgeiALSR0FPMRUm2BkOSNCNKKb
klDy50IKcjl4mcuRGbVaBOoKrYZSlOWEGWGecT1MTneISEMxFKngGQ203o3W
/TDqXmOpFXBNEDMfCznjpPwuOr0OVRgUdsfwBTrwoKP1OlpYChbWvrcRF5Ff
2/uY+/Ir9xSrUrasNLH+9G1EHS7YzgrZswli4dDFQq426C3VUJKjb5+j7Feo
wmLGR1yDQxB4LxyqRnodUTisSCm4T+ksBMqySmmt1Wr9mdb+sLQmy/VaUH3L
qlyUq6l6QBl9keMySkZ6VPKQj7xCzX99q2jd0SCu6eSHZEx7QE/1XPjlHLrt
wdWP2ujmu+41ivqKON1QHxJ3GdavQYOGGg1kvgRY/QV1ZHDBwoFzUjeXAb8D
6J3fnPIpe59R5+t2bwc3/cAzkCC8003L52zD4zKJBZ4XON7Gy2cy36jIYx4Z
jZ1BjwXrUrWKelZbarHWjNdRqbE0xKLxQQTaPW4E8D2R3vMxJaIiLp6WxiaU
sQxED6ZlgbNg1FajxopcLwW9EaypHdt6KkNvGjGGE5rMcTr+eA8OUL+E2ijL
DhqR0GHsPGJ4fTA9VLl9B2PmPTBmx8iE6+gYBZvrFef6E4YRH+NI2FhxcX07
rB4ibLsxWmIPKCXGqRUY9GKYbszAIWbL8OHDByiRzMrRaZGMmY0twqIjYp85
xinBZtUeNCGKx5I2gLPzSYgYJ6m/mGRAKIAHKbuB1HEBTM60s4V+x3KilMsJ
lHSSpyhCzOqGwVw3nkJXfmyE/rbusIjdZG/m/SXCWu36ZqTdDrpDzNO7pRWt
+F8mq6gMSi/fS5Ckj3bAglvMH6bju9YTWBjlMJQu6VOwnJuuiz5EcSoSpjJX
7F7fBDJLxwYvFd9+Oxq0+0uMSlRhirGWTcoHoJtu7ya5h9KmTWLxbjnOR02f
YbYI1VY42v4+Ydokcc2mXEhBM7cq+SOBs2ebnqlb5n+i6I3jY/zNRmQ6ZNYU
RrjPcizppnVWQsvK1gc1dzRqfFICtPa05p36WO0AAbtj0xmL6E4HaoHcV5M8
qSYb/ax0VoRwxS2Ku/6+fbUNm4qzGY4liGkjJLCc8ZjSBsX20eDyr24Qx0mu
BN9divVxuW6KLBiPGremhwSBnWK7jAhpxRWtElj1/1huA1batMRUef1phrvE
GQv6CYgVILRGTREnBw1FzSqI4rvfEmQxgvsskKn3iDGJDqxCke6U2TcoIZEK
pvvi1YRSdgJSfCOaxI2qOCtRGkr1xTtencv9sduMB+8R1213jkjz79SFhltH
eA6FHt0TeBZh56QIngMLeoW/RFY9QVRLedhi8O7yIjgqrapUpTWhUFVr0qoJ
Qc630RpBgG3/ji1IiLa5UCLpWGzCxv4dvAFZSimjotpY87yphzWrhP+Cjj0y
SICtd90b9dpXvX90OzGIFbUMkW9j+CmOtGjsa5D2QHCQRl44WTzMQRr1HeYk
tFtXqblcqNartWSH6YAaNFa2xyUxZoi9JqYeS1qw7yctwriMr/0uaKkc7dfY
+LR7SEKO5+dwdXPR1frdTq+tjbrDkfau3bvqdvL7k0ozviuUC/RJLgJULQt1
LOCCrpZBQftvu7HkZol+yKvnaCkvzKGhtIQ5NOhqRC1mDoIPjogXU8pk2V9O
+SrOyqAA0qMs4Sdim4jDycuxsqoq6NqL2ZOreY52b/Kwrl9Nj1p0vAJDAicr
Cq/wORnAdictrMW2y0kLCfV/cQ5BqRaWaXRoET4fvr+87A6H+zdG3y3rHVo4
iQcOS/sbZQMcYRZo02Ufiu+cwntw7+IJ6MyRvuBiCEeW9zOEEwWQk/qRNCgY
gwZfywe20GpUiwomy2qr3sw4wwhzpKhcCPWKOgjLBqqNqEcSVhL01V3oBiu/
8Dg8dtrxwoOs2Km4GT8fkevgPjh8EovwuLGcKbrJYGKAzUUJ5HNLM/WDQ4wT
TEBKLU9DC+fB71uPr8RyS+OmQ/I1xdDwC2CmHWNtn0DsPspKtZYyE/W+a/Jy
dkqm+pTd+97J0lK227uQYSFe2oxasXO4LYc35BQRE/RE+dqzDc7mzPbQMoTQ
bzodGNNJBVbyE93Tw3GpEGfPuxeEdsiHalJwK6EmSc3ETZItGU9zplOsZILv
5/DT2X6zxGZgOYu+iQbznrMXukclVnR2+GiLorYf2OwajTqJpdSzlyWvmqS2
AmFXq38K+3cXdr1VVIW0a9V9T7g/6yJSLOaLruziTrOdInAZf5SNwD1+8ph4
b1AX8163ggPARCAXNIJgHvz6GuR6+HuhsOOqgZw8O5UepdRQRSdYFEOlWvrL
X8RLJcZd7Pya9rixyp4cVbdyNM3kKJTN69eIBPbnrHoAZ58vK/nlspo423LX
/vw+w8MMMdzylFKWMgQQHkBvvCArDG1VZGmpeba0XSrfkODqe8wg90jAm5sI
CeW3JV2FkAqX0zPu5sOVe9Es5SwrKe+UZ6reV/qWkjc6dmh5xZWgOZ3GC+91
SAjebqnApSiPorzcfl6QcV3kt78yucIWaqNZVGSMwKok74zAMXR+g3AcAzEW
TOFB4iFY3fl/wOp7ovJUUB5i8prUqm+P83sCZF1X1fyhYPb5wGtHu65w/kb3
jdSaKhOGUqsCS5FNvZhuopumG2ONjqpKb4z5RJs4NguvxAosJEUgze7R7csL
7fKm329fd8RpaufmuptoHcQIJFRzDoYzn+v2JHOO648T07B6wWc7plEZEQJL
lEgg2YaqUEuloNbrUlFWY/76KfWSyPb9v4rtnnae33k3p3B05E8wjjzlUi94
WI6zQOf2ba9UOsu45oF8rYcFFzOzImMGQg1fftMedH5oD7oRQHp8yO63xu8X
LJ1ybKA2WuLimNqQkn8QQIyac4apaUu/VYoKe49cktn7SWH8efPvRQTLTblO
f3am0tnO8vZwRswM7gz22x+0dqd9O+oOhvicMMc2rGHyn/9p/jsD22CJvHqZ
dsKliaAWDLl+f3W1e1RwsMTxaS76pghSmiGjVuLzg2Xyx/8F7v4UnJ84AAA=
---472940234-194371071-976217363=:32333--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
